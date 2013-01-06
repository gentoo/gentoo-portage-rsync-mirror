# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/xfsdump/xfsdump-3.0.1.ebuild,v 1.5 2010/05/11 20:51:52 josejx Exp $

inherit multilib

DESCRIPTION="xfs dump/restore utilities"
HOMEPAGE="http://oss.sgi.com/projects/xfs"
SRC_URI="ftp://oss.sgi.com/projects/xfs/cmd_tars/${P}.tar.gz
	ftp://oss.sgi.com/projects/xfs/previous/cmd_tars/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 -sparc x86"
IUSE=""

RDEPEND="sys-fs/e2fsprogs
	!<sys-fs/xfsprogs-3
	sys-apps/dmapi
	>=sys-apps/attr-2.4.19"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^PKG_DOC_DIR/s:@pkg_name@:${PF}:" \
		include/builddefs.in \
		|| die
}

src_compile() {
	unset PLATFORM #184564
	export OPTIMIZER=${CFLAGS}
	export DEBUG=-DNDEBUG

	econf \
		--libdir=/$(get_libdir) \
		--libexecdir=/usr/$(get_libdir) \
		--sbindir=/sbin \
		|| die
	emake || die
}

src_install() {
	emake DIST_ROOT="${D}" install || die
	prepalldocs
}
