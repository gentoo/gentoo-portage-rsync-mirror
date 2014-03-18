# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mate-extra/mate-file-manager-share/mate-file-manager-share-1.6.0.ebuild,v 1.1 2014/03/17 23:11:45 tomwij Exp $

EAPI="5"

GNOME2_LA_PUNT="yes"
GCONF_DEBUG="no"

inherit autotools gnome2 eutils user versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="A Caja plugin to easily share folders over the SMB protocol"
HOMEPAGE="http://mate-desktop.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64"

COMMON_DEPEND=">=dev-libs/glib-2.4:2
	>=mate-base/mate-file-manager-1.6:0
	x11-libs/gtk+:2
	virtual/libintl:0"

RDEPEND="${COMMON_DEPEND}
	net-fs/samba:0"

DEPEND="${COMMON_DEPEND}
	sys-devel/gettext:*
	>=dev-util/intltool-0.29:*
	virtual/pkgconfig:*"

USERSHARES_DIR="/var/lib/samba/usershare"
USERSHARES_GROUP="samba"

src_prepare() {
	# Tarball has no proper build system, should be fixed on next release.
	eautoreconf

	# Remove obsolete files to make test run
	rm src/caja-share.c src/caja-share.h || die
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure --disable-static
}

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_install() {
	gnome2_src_install

	keepdir ${USERSHARES_DIR}
}

pkg_postinst() {
	enewgroup ${USERSHARES_GROUP}
	einfo "Fixing ownership and permissions on ${EROOT}${USERSHARES_DIR#/}..."
	chown root:${USERSHARES_GROUP} "${EROOT}"${USERSHARES_DIR#/}
	chmod 01770 "${EROOT}"${USERSHARES_DIR#/}

	einfo "To get mate-file-manager-share working, add the lines"
	einfo
	einfo "   # Allow users in group \"${USERSHARES_GROUP}\" to share"
	einfo "   # directories with the \"net usershare\" commands"
	einfo "   usershare path = \"${EROOT}${USERSHARES_DIR#/}\""
	einfo "   # Set a maximum of 100 user-defined shares in total"
	einfo "   usershare max shares = 100"
	einfo "   # Allow users to permit guest access"
	einfo "   usershare allow guests = yes"
	einfo "   # Only allow users to share directories they own"
	einfo "   usershare owner only = yes"
	einfo
	einfo "to the end of the [global] section in /etc/samba/smb.conf."
	einfo
	einfo "Users who are to be allowed to use nautilus-share should be added"
	einfo "to the \"${USERSHARES_GROUP}\" group:"
	einfo
	einfo "# gpasswd -a USER ${USERSHARES_GROUP}"
	einfo
	einfo "Users may need to log out and in again for the group assignment to"
	einfo "take effect and to restart Nautilus."
	einfo
	einfo "For more information, see USERSHARE in net(8)."
}
