"""
Admin configuration customisation for the core app.
"""
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from django.utils.translation import gettext as _

from .models import User


class UserAdmin(BaseUserAdmin):
    """Admin interface configuration for the User model.

    Attributes:
        ordering: Default sorting field
        list_display: Fields to display in list view
        fieldsets: Field grouping for edit view
        readonly_fields: Fields that cannot be edited
    """

    ordering = ['id']
    list_display = ['email', 'name']

    fieldsets = (
        (None, {'fields': ('email', 'password')}),
        (_('Personal Info'), {'fields': ('name',)}),
        (
            _('Permissions'),
            {
                'fields': (
                    'is_active',
                    'is_staff',
                    'is_superuser',
                )
            }
        ),
        (_('Important dates'), {'fields': ('last_login',)}),
    )
    readonly_fields = ['last_login']
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': (
                'email',
                'password1',
                'password2',
                'name',
                'is_active',
                'is_staff',
            ),
        }),
    )


admin.site.register(User, UserAdmin)
