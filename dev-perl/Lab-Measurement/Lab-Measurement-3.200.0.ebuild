# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lab-Measurement/Lab-Measurement-3.200.0.ebuild,v 1.1 2013/10/19 18:31:56 dilfridge Exp $

EAPI=5

if [[ "${PV}" != "9999" ]]; then
	MODULE_VERSION="3.20"
	MODULE_AUTHOR="AKHUETTEL"
	KEYWORDS="~amd64 ~x86"
	inherit perl-module
else
	EGIT_REPO_URI="git://gitorious.org/lab-measurement/lab.git"
	EGIT_BRANCH="master"
	EGIT_SOURCEDIR=${S}
	KEYWORDS=""
	S=${WORKDIR}/${P}/Measurement
	inherit perl-module git-2
fi

DESCRIPTION="Measurement control and automation with Perl"
HOMEPAGE="http://www.labmeasurement.de/"

# this is perl's license, whatever it means
LICENSE="|| ( Artistic GPL-2 )"

SLOT="0"
IUSE="debug +xpression"

RDEPEND="
	dev-perl/Clone
	dev-perl/Exception-Class
	dev-perl/Hook-LexWrap
	dev-perl/TermReadKey
	dev-perl/TeX-Encode
	dev-perl/XML-Generator
	dev-perl/XML-DOM
	dev-perl/XML-Twig
	dev-perl/encoding-warnings
	sci-visualization/gnuplot
	virtual/perl-Class-ISA
	virtual/perl-Data-Dumper
	virtual/perl-Encode
	virtual/perl-Switch
	virtual/perl-Time-HiRes
	!dev-perl/Lab-Instrument
	!dev-perl/Lab-Tools
	debug? (
		dev-lang/perl[ithreads]
		dev-perl/wxperl
	)
	xpression? (
		dev-perl/wxperl
	)
"
DEPEND="
	${RDEPEND}
	virtual/perl-Module-Build
"

pkg_postinst() {
	if ( ! has_version sci-libs/linuxgpib ) && ( ! has_version dev-perl/Lab-VISA ) ; then
		elog "You may want to install one or more backend driver modules. Supported are"
		elog "    sci-libs/linuxgpib    Open-source GPIB hardware driver"
		elog "    dev-perl/Lab-VISA     Bindings for the NI proprietary VISA driver"
		elog "                          stack (dilfridge overlay)"
	fi
}
