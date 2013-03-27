# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dmapi/dmapi-2.2.12.ebuild,v 1.5 2013/03/27 09:35:46 ago Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="XFS data management API library"
HOMEPAGE="http://oss.sgi.com/projects/xfs/"
SRC_URI="ftp://oss.sgi.com/projects/xfs/cmd_tars/${P}.tar.gz
	ftp://oss.sgi.com/projects/xfs/previous/cmd_tars/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ppc ppc64 ~sparc x86"
IUSE="static-libs"

RDEPEND="sys-fs/xfsprogs"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i \
		-e "/^PKG_DOC_DIR/s:@pkg_name@:${PF}:" \
		include/builddefs.in \
		|| die
}

src_configure() {
	export OPTIMIZER=${CFLAGS}
	export DEBUG=-DNDEBUG

	econf \
		--libexecdir=/usr/$(get_libdir) \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install install-dev
	gen_usr_ldscript -a dm
	find "${ED}"/usr '(' -name '*.la' -o -name COPYING ')' -delete
}
