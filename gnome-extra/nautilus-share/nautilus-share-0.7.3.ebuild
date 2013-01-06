# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-share/nautilus-share-0.7.3.ebuild,v 1.2 2012/06/07 22:23:13 zmedico Exp $

EAPI=4

inherit gnome2 eutils user

DESCRIPTION="A nautilus plugin to easily share folders over the SMB protocol"
HOMEPAGE="http://gentoo.ovibes.net/nautilus-share http://packages.debian.org/unstable/nautilus-share"
SRC_URI="mirror://debian/pool/main/n/${PN}/${PN}_${PV}.orig.tar.bz2
		 mirror://debian/pool/main/n/${PN}/${PN}_${PV}-1.debian.tar.gz"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND="gnome-base/nautilus
	dev-libs/glib"
RDEPEND="${DEPEND}
	net-fs/samba"

DOCS="AUTHORS ChangeLog NEWS README TODO"

USERSHARES_DIR="/var/lib/samba/usershare"
USERSHARES_GROUP="samba"

src_prepare() {
	epatch "${WORKDIR}"/debian/patches/15_user-acl.patch
}

src_install() {
	gnome2_src_install
	keepdir ${USERSHARES_DIR}
}

pkg_postinst() {
	enewgroup ${USERSHARES_GROUP}
	einfo "Fixing ownership and permissions on ${EROOT}${USERSHARES_DIR}..."
	chown root:${USERSHARES_GROUP} "${EROOT}"${USERSHARES_DIR}
	chmod 01770 "${EROOT}"${USERSHARES_DIR}

	einfo "To get nautilus-share working, add the lines"
	einfo
	einfo "   # Allow users in group \"${USERSHARES_GROUP}\" to share"
	einfo "   # directories with the \"net usershare\" commands"
	einfo "   usershare path = \"${EROOT}${USERSHARES_DIR}\""
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
