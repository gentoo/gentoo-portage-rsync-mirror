# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwids/hwids-99999999.ebuild,v 1.13 2012/12/09 16:02:37 grobian Exp $

EAPI=5
inherit udev git-2

DESCRIPTION="Hardware (PCI, USB, OUI, IAB) IDs databases"
HOMEPAGE="https://github.com/gentoo/hwids"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="|| ( GPL-2 BSD ) public-domain"
SLOT="0"
KEYWORDS=""
IUSE="+udev"

DEPEND="net-misc/curl
	udev? ( dev-lang/perl !=sys-fs/udev-196 )"
RDEPEND="!<sys-apps/pciutils-3.1.9-r2
	!<sys-apps/usbutils-005-r1"

src_prepare() {
	emake fetch
}

src_configure() {
	MAKEOPTS+=" UDEV=$(usex udev)"
	MAKEOPTS+=" DOCDIR=${EPREFIX}/usr/share/doc/${PF}"
	MAKEOPTS+=" MISCDIR=${EPREFIX}/usr/share/misc"
	MAKEOPTS+=" HWDBDIR=${EPREFIX}$(udev_get_udevdir)/hwdb.d"
	MAKEOPTS+=" DESTDIR=${D}"
}

pkg_postinst() {
	if use udev && [[ $(udevadm --help 2>&1) == *hwdb* ]]; then
		udevadm hwdb --update
	fi
}
