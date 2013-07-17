# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/last/last-299.ebuild,v 1.1 2013/07/17 07:48:28 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils toolchain-funcs python-r1

DESCRIPTION="Genome-scale comparison of biological sequences"
HOMEPAGE="http://last.cbrc.jp/"
SRC_URI="http://last.cbrc.jp/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip"
RDEPEND=""

src_prepare() {
	sed \
		-e 's:-o $@:$(LDFLAGS) -o $@:g' \
		-i src/makefile || die
}

src_compile() {
	emake \
		-e -C src \
		CXX="$(tc-getCXX)" \
		CC="$(tc-getCC)" \
		STRICT="" || die
}

src_install() {
	local i

	dobin src/last{al,db,ex}

	dodoc doc/*.txt ChangeLog.txt README.txt
	dohtml doc/*html

	cd scripts || die
	for i in *py; do
		python_parallel_foreach_impl python_newscript ${i} ${i%.py}
	done
	dobin *sh
}
