# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mafft/mafft-6.811.ebuild,v 1.3 2011/11/21 15:30:19 jlec Exp $

EAPI="3"

inherit eutils flag-o-matic multilib toolchain-funcs

EXTENSIONS="-without-extensions"

DESCRIPTION="Multiple sequence alignments using a variety of algorithms"
HOMEPAGE="http://mafft.cbrc.jp/alignment/software/index.html"
SRC_URI="http://mafft.cbrc.jp/alignment/software/${P}${EXTENSIONS}-src.tgz"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos ~x86-macos"
IUSE="threads"

S="${WORKDIR}"/${P}${EXTENSIONS}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-respect.patch
	use threads && append-flags -Denablemultithread
	sed "s:GENTOOLIBDIR:$(get_libdir):g" -i core/Makefile
	sed -i -e "s/(PREFIX)\/man/(PREFIX)\/share\/man/" "${S}"/core/Makefile || die "sed failed"
}

src_compile() {
	pushd core
	emake \
		PREFIX="${EPREFIX}"/usr \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		|| die "make failed"
	popd
}

src_install() {
	pushd core
	emake PREFIX="${ED}usr" install || die "install failed"
	popd
	dodoc readme || die
}
