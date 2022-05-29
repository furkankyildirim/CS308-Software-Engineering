from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from api import deps

import crud, models, schemas
from models.favorite import Favorite
from schemas import Response
from typing import List

from schemas.favorite import FavoriteBase

router = APIRouter()

#get post and update favorite table
@router.post("/favorite", response_model=Response[FavoriteBase])
async def favorite(
    favorite_details: schemas.FavoriteCreate,
    db: Session = Depends(deps.get_db),
    current_user: models.User = Depends(deps.get_current_user),
):
    """
    Add product to favorite table.
    """

    favorite = crud.favorite.create_favorite(
        db=db, user_id=current_user.id, favorite_details=favorite_details
    )

    return Response(data=favorite ,message="Successfully added product to favorite")

@router.get("/favorites", response_model=Response[List[schemas.FavoriteInDBBase]])
async def previous_favorites(
    skip: int = 0,
    limit: int = 100,
    db: Session = Depends(deps.get_db),
    current_user: models.User = Depends(deps.get_current_user),
):
    """
    Get previous favorites
    """
    data = crud.favorite.get_multi(db=db, user_id=current_user.id, skip=skip, limit=limit)

    return Response(data=data)

@router.patch("/favorite/{product_id}", response_model=Response[FavoriteBase])
async def update_favorite(
    product_id: int,
    favorite_details: schemas.FavoriteUpdate,
    db: Session = Depends(deps.get_db),
    current_user: models.User = Depends(deps.get_current_user),
):
    """
    Update favorite
    """
    favorite = crud.favorite.update_favorite(
        db=db,
        current_user=current_user.id,
        product_id=product_id,
        favorite_details=favorite_details,
    )

    return Response(data=favorite, message="Successfully updated favorite")

@router.delete("/favorite/{product_id}", response_model=Response)
async def delete_favorite(
    product_id: int,
    db: Session = Depends(deps.get_db),
    current_user: models.User = Depends(deps.get_current_user),
):
    """
    Delete product from favorite table.
    """

    crud.favorite.delete_favorite(db=db, current_user=current_user.id, product_id=product_id)

    return Response(message="Successfully deleted product from favorite")

@router.delete("/favorites", response_model=Response)
async def delete_all_favorites(
    db: Session = Depends(deps.get_db),
    current_user: models.User = Depends(deps.get_current_user),
):
    """
    Delete all products from favorite table.
    """

    crud.favorite.delete_all_favorites(db=db, user_id=current_user.id)

    return Response(message="Successfully deleted all products from favorite")
