# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/paml/paml-4.4c.ebuild,v 1.3 2010/09/12 16:16:35 hwoarang Exp $

EAPI="2"

inherit toolchain-funcs versionator

MY_P=$(version_format_string '${PN}$1$2')

DESCRIPTION="Phylogenetic Analysis by Maximum Likelihood"
HOMEPAGE="http://abacus.gene.ucl.ac.uk/software/paml.html"
SRC_URI="http://abacus.gene.ucl.ac.uk/software/${PN}${PV}.tar.gz"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	# Notice send by mail to prof. Ziheng Yang
	sed -i "s/\$(CC)/& \$(LDFLAGS)/" src/Makefile || die #335608
}

src_compile() {
	emake -C src CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	pushd "${S}"/src
	dobin baseml codeml basemlg mcmctree pamp evolver yn00 chi2 || die
	popd
	dodoc README.txt doc/* || die
	insinto /usr/share/${PN}/control
	doins *.ctl || die "Failed to install control files"
	insinto /usr/share/${PN}/dat
	doins stewart* *.dat dat/* || die "Failed to install data files"
	insinto /usr/share/${PN}
	doins -r examples/ || die "Failed to install examples"
}
