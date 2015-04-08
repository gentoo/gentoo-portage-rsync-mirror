# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/crf++/crf++-0.53.ebuild,v 1.2 2010/12/02 01:18:51 flameeyes Exp $

inherit autotools eutils

MY_P="${P/crf/CRF}"
DESCRIPTION="Yet Another CRF toolkit for segmenting/labelling sequential data"
HOMEPAGE="http://crfpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/crfpp/${MY_P}.tar.gz"

LICENSE="|| ( BSD LGPL-2.1 )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/CFLAGS/s/-O3/${CFLAGS}/" \
		-e "/CXXFLAGS/s/-O3/${CXXFLAGS}/" \
		configure.in || die
	eautoreconf
}

src_test() {
	for task in example/* ; do
		(
			cd "${task}"
			./exec.sh || die "failed test in ${task}"
		)
	done
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS README
	dohtml doc/*

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r example
	fi
}
