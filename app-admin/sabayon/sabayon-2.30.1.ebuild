# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sabayon/sabayon-2.30.1.ebuild,v 1.11 2012/05/31 02:37:59 zmedico Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.5"

inherit gnome2 eutils python multilib user

DESCRIPTION="Tool to maintain user profiles in a GNOME desktop"
HOMEPAGE="http://live.gnome.org/Sabayon/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

# Unfortunately the configure.ac is wildly insufficient, so dependencies have
# to be got from the RPM .spec file...
# But the .spec file got removed :/
COMMON_DEPEND=">=x11-libs/gtk+-2.6:2
	>=dev-python/pygtk-2.16:2
	>=dev-python/pygobject-2.15:2
	app-admin/pessulus
	x11-libs/pango
	dev-python/python-ldap
	x11-base/xorg-server[kdrive]"

RDEPEND="${COMMON_DEPEND}
	dev-python/pyxdg
	dev-libs/libxml2:2[python]
	>=gnome-base/gconf-2.8.1:2
	>=dev-python/libbonobo-python-2.6:2
	>=dev-python/gconf-python-2.6:2
	x11-libs/gksu"

DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40
	>=app-text/gnome-doc-utils-0.17.3"

pkg_setup() {
	DOCS="AUTHORS ChangeLog ISSUES NEWS README TODO"
	G2CONF="${G2CONF}
		--disable-static
		--with-distro=gentoo
		--with-prototype-user=${PN}-admin
		--enable-console-helper=no"

	einfo "Adding user '${PN}-admin' as the prototype user"
	# I think /var/lib/sabayon is the correct directory to use here.
	enewgroup ${PN}-admin
	enewuser ${PN}-admin -1 -1 "/var/lib/sabayon" "${PN}-admin"
	# Should we delete the user/group on unmerge?
	python_set_active_version 2
}

src_prepare() {
	gnome2_src_prepare

	# Switch gnomesu to gksu; bug #197865
	sed -i 's/Exec=/Exec=gksu /' admin-tool/sabayon.desktop || die "gksu sed failed"
	sed -i 's/Exec=/Exec=gksu /' admin-tool/sabayon.desktop.in || die "gksu sed failed"

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile

	python_convert_shebangs -r 2 .
}

src_install() {
	gnome2_src_install
	python_clean_installation_image
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize sabayon

	# unfortunately /etc/gconf is CONFIG_PROTECT_MASK'd
	elog "To apply Sabayon defaults and mandatory settings to all users, put"
	elog '    include "$(HOME)/.gconf.path.mandatory"'
	elog "in /etc/gconf/2/local-mandatory.path and put"
	elog '    include "$(HOME)/.gconf.path.defaults"'
	elog "in /etc/gconf/2/local-defaults.path."
	elog "You can safely create these files if they do not already exist."
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup sabayon
}
