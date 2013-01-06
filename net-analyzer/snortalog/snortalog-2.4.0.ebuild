# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snortalog/snortalog-2.4.0.ebuild,v 1.11 2010/07/19 21:51:23 maekke Exp $

inherit eutils

MY_P="${PN}_v${PV}"

DESCRIPTION="a powerful perl script that summarizes snort logs"
SRC_URI="http://jeremy.chartier.free.fr/snortalog/${MY_P}.tgz
	tk? ( mirror://gentoo/${P}-fix-gui.diff.gz )"
HOMEPAGE="http://jeremy.chartier.free.fr/snortalog/"

KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="tk"

DEPEND="dev-lang/perl
	virtual/perl-Getopt-Long
	virtual/perl-DB_File
	dev-perl/HTML-HTMLDoc
	tk? ( dev-perl/perl-tk dev-perl/GDGraph )"
RDEPEND=${DEPEND}

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# one file created at a time ( pdf or html )
	epatch "${FILESDIR}/${P}-limit-args.diff"

	if use tk ; then
		epatch "${DISTDIR}/${P}-fix-gui.diff.gz"
	else
		epatch "${FILESDIR}/${P}-notcltk.diff"
	fi

	# fix paths, erroneous can access message
	sed -i -e "s:\(modules/\):/usr/lib/snortalog/${PV}/\1:g" \
		-e 's:\($domains_file = "\)conf/\(domains\)\(".*\):\1/etc/snortalog/\2\3:' \
		-e 's:\($rules_file = "\)conf/\(rules\)\(".*\):\1/etc/snortalog/\2\3:' \
		-e 's:\($picts_dir ="\)picts\(".*\):\1/etc/snortalog/picts\2:' \
		-e 's:\($hw_file = "\)conf/\(hw\)\(".*\):\1/etc/snortalog/\2\3:' \
		-e 's:\($lang_file ="\)conf/\(lang\)\(".*\):\1/etc/snortalog/\2\3:' \
		-e 's:Can access:Cannot access:' \
		snortalog.pl || die "sed snortalog.pl failed"
}

src_install () {
	dobin snortalog.pl || die

	insinto /etc/snortalog
	doins conf/{domains,hw,lang,rules}

	insinto /etc/snortalog/picts
	doins picts/*

	insinto /usr/lib/snortalog/${PV}/modules
	doins -r modules/*

	dodoc doc/CHANGES
}
