# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/encfs/encfs-1.7.2.ebuild,v 1.5 2012/10/31 23:14:20 flameeyes Exp $

EAPI=2
inherit multilib

DESCRIPTION="An implementation of encrypted filesystem in user-space using FUSE"
HOMEPAGE="http://www.arg0.net/encfs/"
SRC_URI="http://encfs.googlecode.com/files/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE="xattr"

RDEPEND=">=dev-libs/boost-1.34
	>=dev-libs/openssl-0.9.7
	>=dev-libs/rlog-1.4
	>=sys-fs/fuse-2.7.0"
DEPEND="${RDEPEND}
	dev-lang/perl
	virtual/pkgconfig
	xattr? ( sys-apps/attr )
	sys-devel/gettext"

src_configure() {
	use xattr || export ac_cv_header_attr_xattr_h=no

	econf \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
	find "${D}" -name '*.la' -delete
}
