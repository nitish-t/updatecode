package com.app.roadz.modules.Home.Menu;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.io.Serializable;


@JsonIgnoreProperties(ignoreUnknown = true)
public class MenuItem implements Serializable {


    private String Menu_Name;
    private int Menu_Icon;

    private MenuEnum Menu_Enum;

    public MenuItem() {
    }

    public MenuItem(String menu_Name, int Menu_Icon, MenuEnum menu_Enum) {
        Menu_Name = menu_Name;
        this.Menu_Icon = Menu_Icon;
        Menu_Enum = menu_Enum;
    }

    public String getMenu_Name() {
        return Menu_Name;
    }

    public void setMenu_Name(String menu_Name) {
        Menu_Name = menu_Name;
    }

    public int getMenu_Icon() {
        return Menu_Icon;
    }

    public void setMenu_Icon(int menu_Icon) {
        Menu_Icon = menu_Icon;
    }

    public String getMenu_Enum() {
        if (Menu_Enum == null) return "";
        return Menu_Enum.getValue();
    }

    public void setMenu_Enum(MenuEnum menu_Enum) {
        Menu_Enum = menu_Enum;
    }


    public static enum MenuEnum {
        HOME("HOME"),
        PROFILE("PROFILE"),
        CARS("CARS"),
        SUBSCRIPTIONS("SUBSCRIPTIONS"),
        SERVICES("SERVICES"),
        ABOUT_US("ABOUT_US"),
        CONTACT_US("CONTACT_US"),
        SETTINGS("SETTINGS"),
        LOGOUT("LOGOUT");

        static MenuEnum mapIntToValue(final String qCodeType) {
            for (MenuEnum value : MenuEnum.values()) {
                if (qCodeType == value.getValue()) {
                    return value;
                }
            }

            // If not, return default
            return getDefault();
        }

        static MenuEnum getDefault() {
            return HOME;
        }

        private String mIntValue;

        MenuEnum(String MenuInt) {
            mIntValue = MenuInt;
        }

        public String getValue() {
            return mIntValue;
        }
    }


}