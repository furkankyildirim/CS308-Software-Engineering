"""ordering_categories_v1

Revision ID: ba63ff2efd83
Revises: e9842be92824
Create Date: 2022-05-07 07:56:57.082868

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'ba63ff2efd83'
down_revision = 'e9842be92824'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('category', sa.Column('order', sa.Integer(), nullable=False))
    op.add_column('subcategory', sa.Column('order', sa.Integer(), nullable=False))
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('subcategory', 'order')
    op.drop_column('category', 'order')
    # ### end Alembic commands ###
