# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/secure-delete/secure-delete-3.1.ebuild,v 1.9 2008/12/30 20:20:14 angelos Exp $

inherit eutils toolchain-funcs

MY_P=${PN//-/_}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Secure file/disk/swap/memory erasure utilities"
HOMEPAGE="http://www.thc.org/"
SRC_URI="http://www.thc.org/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND="!app-misc/srm"

src_unpack() {
	unpack ${A}
	cd "${S}"
	chmod u+w .

	sed -i \
		-e 's|mktemp|mkstemp|g' \
		sfill.c

	sed -i -e "/strip/d" Makefile

	# the kernel module will not compile without smp support and there is no
	# good way to ensure that a user has it
	epatch "${FILESDIR}"/${PN}-3.1-do-not-use-the-kernel-module.patch
}

src_compile() {
	emake -j1 OPT="${CFLAGS} -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64" \
		CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake \
		INSTALL_DIR="${D}"/usr/bin \
		MAN_DIR="${D}"/usr/share/man \
		DOC_DIR="${D}"/usr/share/doc/${PF} \
		install || die "emake install failed"

	dodoc secure_delete.doc usenix6-gutmann.doc
}

pkg_postinst() {
	ewarn "sfill and srm are useless on journaling filesystems,"
	ewarn "such as reiserfs or XFS."
	ewarn "See documentation for more information."

	elog "The kernel module has been removed since it does not compile"
	elog "for non-smp kernels."
}
