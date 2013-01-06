# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mafft/mafft-6.707.ebuild,v 1.2 2010/06/24 19:30:59 jlec Exp $

inherit toolchain-funcs multilib eutils

EXTENSIONS="-without-extensions"

DESCRIPTION="Multiple sequence alignments using a variety of algorithms"
HOMEPAGE="http://align.bmr.kyushu-u.ac.jp/mafft/software/"
SRC_URI="http://align.bmr.kyushu-u.ac.jp/mafft/software/${P}${EXTENSIONS}-src.tgz"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
S=${WORKDIR}/${P}${EXTENSIONS}

src_unpack() {
	unpack ${A}
	sed -i -e "s/(PREFIX)\/man/(PREFIX)\/share\/man/" "${S}"/core/Makefile || die "sed failed"
}

src_compile() {
	pushd core
	emake \
		PREFIX=/usr \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		|| die "make failed"
	popd
}

src_install() {
	pushd core
	emake PREFIX="${D}usr" install || die "install failed"
	popd
	dodoc readme || die
}
