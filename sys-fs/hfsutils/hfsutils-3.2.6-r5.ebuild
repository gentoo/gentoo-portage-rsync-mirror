# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/hfsutils/hfsutils-3.2.6-r5.ebuild,v 1.5 2009/09/11 11:34:55 flameeyes Exp $

inherit eutils toolchain-funcs

DESCRIPTION="HFS FS Access utils"
HOMEPAGE="http://www.mars.org/home/rob/proj/hfs/"
SRC_URI="ftp://ftp.mars.org/pub/hfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="tcl tk"

DEPEND="tcl? ( dev-lang/tcl )
		tk? ( dev-lang/tk )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/hfsutils-3.2.6-errno.patch
	epatch "${FILESDIR}"/largerthan2gb.patch
}

src_compile() {
	tc-export CC CPP LD RANLIB
	### use tk implies --with-tcl - bug #150437
	if use tk; then
		econf --with-tcl --with-tk || die
	else
		econf \
			$(use_with tcl) \
			$(use_with tk) \
			|| die
	fi
	emake PREFIX=/usr MANDIR=/usr/share/man || die
	emake -C hfsck PREFIX=/usr MANDIR=/usr/share/man || die
}

src_install() {
	dodir /usr/bin /usr/lib /usr/share/man/man1
	make \
		prefix="${D}"/usr \
		MANDEST="${D}"/usr/share/man \
		infodir="${D}"/usr/share/info \
		install || die
	dobin hfsck/hfsck || die
	dodoc BLURB CHANGES README TODO doc/*.txt
}
