# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dmapi/dmapi-2.2.10.ebuild,v 1.8 2012/12/02 10:50:26 maekke Exp $

inherit toolchain-funcs

DESCRIPTION="XFS data management API library"
HOMEPAGE="http://oss.sgi.com/projects/xfs/"
SRC_URI="ftp://oss.sgi.com/projects/xfs/cmd_tars/${P}.tar.gz
	ftp://oss.sgi.com/projects/xfs/previous/cmd_tars/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND="sys-fs/xfsprogs"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^PKG_DOC_DIR/s:@pkg_name@:${PF}:" \
		include/builddefs.in \
		|| die "failed to update builddefs"
}

src_compile() {
	export OPTIMIZER=${CFLAGS}
	export DEBUG=-DNDEBUG

	econf --libexecdir=/usr/$(get_libdir) || die
	emake || die
}

src_install() {
	emake DIST_ROOT="${D}" install install-dev || die
	gen_usr_ldscript -a dm
	prepalldocs
}
