# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/readseq/readseq-19930201-r1.ebuild,v 1.1 2010/11/28 08:56:48 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Reads and writes nucleic/protein sequences in various formats."
SRC_URI="mirror://debian/pool/main/r/readseq/readseq_1.orig.tar.gz"
HOMEPAGE="http://iubio.bio.indiana.edu/soft/molbio/readseq/"
LICENSE="public-domain"

KEYWORDS="~amd64 ~sparc ~x86"
SLOT="0"
IUSE=""

S="${WORKDIR}/readseq-1"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PV}-getline.patch \
		"${FILESDIR}"/${PV}-buffer.patch \
		"${FILESDIR}"/${PV}-impl-dec.patch \
		"${FILESDIR}"/${PV}-ldflags.patch
}

src_compile() {
	emake -e \
		CC=$(tc-getCC) \
		build || die
}

src_install() {
	dobin readseq || die
	dodoc Readme Readseq.help || die
}
