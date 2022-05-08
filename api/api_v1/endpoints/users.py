from operator import add
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from api import deps
from core.security import get_password_hash, verify_password

import crud, models, schemas
from schemas import Response
from typing import Any, List

from schemas.user import ChangePasswordIn, UserBase, UserUpdate

router = APIRouter()

@router.get("/", response_model=Response[UserBase])
def get_user(
    *,
    db: Session = Depends(deps.get_db),
    current_user: models.User = Depends(deps.get_current_user),
) -> Any:
    """
    Get user data such as email and name, this needs to be updated when a new data point is added to the user
    """
    return Response(message="User data", data=UserBase(email=current_user.email, full_name=current_user.full_name, is_active=current_user.is_active))

@router.patch("/change_user_data", response_model=Response[UserBase])
def update_user(
    *,
    db: Session = Depends(deps.get_db),
    current_user: models.User = Depends(deps.get_current_user),
    user_in: UserUpdate
) -> Any:
    """
    Change user data exept for password
    """
    #I am assuming the only necesary check for the update of the user info would have been existance check but 
    #we already know it exists thanks to the currnet_user
    user = crud.user.update(
        db, db_obj=current_user, obj_in=user_in)
    return Response(message="Updated successfully")



@router.patch("/change_password", response_model=Response)
def update_password(
    *,
    db: Session = Depends(deps.get_db),
    current_user: models.User = Depends(deps.get_current_user),
    change_in: schemas.ChangePasswordIn
) -> Any:
    """
    Updates the password of current user
    """
    #check the efficacy of the old_password
    if not verify_password(change_in.current_password,current_user.hashed_password):
         raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail={"message": f"The password entered is wrong"},
        )
    #be annoying
    if change_in.current_password==change_in.new_password:
        raise HTTPException(
            status_code=status.HTTP_406_NOT_ACCEPTABLE,
            detail={"message": f"New password cannot be your old password"},
        )
    hashed= get_password_hash(change_in.new_password)
    current_user.hashed_password=hashed
    db.add(current_user)
    db.commit()
    return Response(message="Updated password of user successfully.")
