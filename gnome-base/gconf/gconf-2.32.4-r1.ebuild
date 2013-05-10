# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gconf/gconf-2.32.4-r1.ebuild,v 1.1 2013/05/10 10:36:24 eva Exp $

EAPI="5"
GCONF_DEBUG="yes"
GNOME_ORG_MODULE="GConf"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2

DESCRIPTION="GNOME configuration system and daemon"
HOMEPAGE="http://projects.gnome.org/gconf/"

LICENSE="LGPL-2+"
SLOT="2"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="debug gtk +introspection ldap policykit"

RDEPEND="
	>=dev-libs/glib-2.25.9:2
	>=x11-libs/gtk+-2.14:2
	>=dev-libs/dbus-glib-0.74:=
	>=sys-apps/dbus-1:=
	>=gnome-base/orbit-2.4:2
	>=dev-libs/libxml2-2:2
	introspection? ( >=dev-libs/gobject-introspection-0.9.5:= )
	ldap? ( net-nds/openldap:= )
	policykit? ( sys-auth/polkit:= )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.35
	virtual/pkgconfig
"

pkg_setup() {
	kill_gconf
}

src_prepare() {
	# Do not start gconfd when installing schemas, fix bug #238276, upstream #631983
	epatch "${FILESDIR}/${PN}-2.24.0-no-gconfd.patch"

	# Do not crash in gconf_entry_set_value() when entry pointer is NULL, upstream #631985
	epatch "${FILESDIR}/${PN}-2.28.0-entry-set-value-sigsegv.patch"

	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-static \
		--enable-gsettings-backend \
		$(use_enable gtk) \
		$(usex gtk --with-gtk=2.0 "") \
		$(use_enable introspection) \
		$(use_with ldap openldap) \
		$(use_enable policykit defaults-service) \
		ORBIT_IDL=$(type -P orbit-idl-2)
}

src_install() {
	gnome2_src_install

	keepdir /etc/gconf/gconf.xml.mandatory
	keepdir /etc/gconf/gconf.xml.defaults
	# Make sure this directory exists, bug #268070, upstream #572027
	keepdir /etc/gconf/gconf.xml.system

	echo "CONFIG_PROTECT_MASK=\"/etc/gconf\"" > 50gconf
	echo 'GSETTINGS_BACKEND="gconf"' >> 50gconf
	doenvd 50gconf
	dodir /root/.gconfd
}

pkg_preinst() {
	kill_gconf
}

pkg_postinst() {
	kill_gconf

	# change the permissions to avoid some gconf bugs
	einfo "changing permissions for gconf dirs"
	find  "${EPREFIX}"/etc/gconf/ -type d -exec chmod ugo+rx "{}" \;

	einfo "changing permissions for gconf files"
	find  "${EPREFIX}"/etc/gconf/ -type f -exec chmod ugo+r "{}" \;
}

kill_gconf() {
	# This function will kill all running gconfd-2 that could be causing troubles
	if [ -x "${EPREFIX}"/usr/bin/gconftool-2 ]
	then
		"${EPREFIX}"/usr/bin/gconftool-2 --shutdown
	fi

	return 0
}
