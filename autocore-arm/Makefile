# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) 2020 Lean <coolsnowwolf@gmail.com>
# Copyright (C) 2021 ImmortalWrt.org

include $(TOPDIR)/rules.mk

PKG_NAME:=autocore
PKG_FLAGS:=nonshared
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_CONFIG_DEPENDS:= \
	CONFIG_TARGET_bcm27xx \
	CONFIG_TARGET_bcm53xx

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/target.mk

define Package/autocore-arm
  TITLE:=ARM auto core script.
  MAINTAINER:=CN_SZTL
  DEPENDS:=@(arm||aarch64) \
    +TARGET_bcm27xx:bcm27xx-userland \
    +TARGET_bcm53xx:nvram
  VARIANT:=arm
endef

define Package/autocore-x86
  TITLE:=x86/x64 auto core loadbalance script.
  MAINTAINER:=Lean / CN_SZTL
  DEPENDS:=@TARGET_x86 +lm-sensors +ethtool
  VARIANT:=x86
endef

define Build/Compile
endef

define Package/autocore/install/Default
	$(INSTALL_DIR) $(1)/etc
	$(CP) ./files/generic/10_system.js $(1)/etc/rpcd_10_system.js
	$(CP) ./files/generic/29_ports.js $(1)/etc/rpcd_29_ports.js
	$(CP) ./files/generic/luci $(1)/etc/rpcd_luci
	$(CP) ./files/generic/sys.uc $(1)/etc/ucode_sys

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/generic/090-cover-index_files $(1)/etc/uci-defaults/

	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_BIN) ./files/generic/cpuinfo $(1)/sbin/
	$(INSTALL_BIN) ./files/generic/ethinfo $(1)/sbin/

	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(CP) ./files/generic/luci-mod-status-autocore.json $(1)/usr/share/rpcd/acl.d/
endef

define Package/autocore-arm/install
	$(call Package/autocore/install/Default,$(1))

ifneq ($(filter ipq% %mt7622, $(TARGETID)),)
	$(INSTALL_BIN) ./files/arm/tempinfo $(1)/sbin/
endif
endef

define Package/autocore-x86/install
	$(call Package/autocore/install/Default,$(1))

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/x86/autocore $(1)/etc/init.d/
endef

$(eval $(call BuildPackage,autocore-arm))
$(eval $(call BuildPackage,autocore-x86))
