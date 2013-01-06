# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dmapi/dmapi-2.2.8.ebuild,v 1.11 2008/10/11 09:51:00 flameeyes Exp $

inherit eutils toolchain-funcs autotools

MY_P="${PN}_${PV}-1"
DESCRIPTION="XFS data management API library"
HOMEPAGE="http://oss.sgi.com/projects/xfs/"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="sys-fs/xfsprogs"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.2.1-only-symlink-when-needed.patch
	epatch "${FILESDIR}"/${PN}-2.2.8-LDFLAGS.patch
	epatch "${FILESDIR}"/${PN}-2.2.8-symlinks.patch #180672
	sed -i \
		-e "/^PKG_DOC_DIR/s:@pkg_name@:${PF}:" \
		include/builddefs.in \
		|| die "failed to update builddefs"
	eautoconf
}

src_compile() {
	export OPTIMIZER=${CFLAGS}
	export DEBUG=-DNDEBUG

	econf --libexecdir=/usr/$(get_libdir) || die
	emake || die
}

src_install() {
	emake DIST_ROOT="${D}" install install-dev || die
	prepalldocs

	# move shared libs to /
	dodir /$(get_libdir)
	mv "${D}"/usr/$(get_libdir)/libdm.so* "${D}"/$(get_libdir)/ || die
	gen_usr_ldscript libdm.so
}
