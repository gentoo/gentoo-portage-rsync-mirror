# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/phrap/phrap-1.080812.ebuild,v 1.4 2013/02/17 10:28:37 jlec Exp $

DESCRIPTION="Phrap, swat, cross_match: Shotgun assembly and alignment utilities"
HOMEPAGE="http://www.phrap.org/"
SRC_URI="phrap-${PV}-distrib.tar.gz"

LICENSE="phrap"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl
		dev-perl/perl-tk"

S="${WORKDIR}"

RESTRICT="fetch"

pkg_nofetch() {
	einfo "Please visit http://www.phrap.org/phredphrapconsed.html and obtain the file"
	einfo "\"distrib.tar.gz\", then rename it to \"phrap-${PV}-distrib.tar.gz\""
	einfo "and put it in ${DISTDIR}"
}

src_compile() {
	sed -i 's/CFLAGS=/#CFLAGS=/' makefile
	sed -i 's|#!/usr/local/bin/perl|#!/usr/bin/env perl|' phrapview
	emake || die "emake failed"
	# TODO: we need to extract staden sources because for compilation some of those
	# files are needed: http://www.phrap.org/phredphrap/phrap.html
	# (look for gcphrap and other gc* programs)
	# emake gcphrap || die
}

src_install() {
	dobin cluster cross_match loco phrap phrapview swat
	for i in {general,phrap,swat}.doc ; do
		newdoc ${i} ${i}.txt
	done
}
