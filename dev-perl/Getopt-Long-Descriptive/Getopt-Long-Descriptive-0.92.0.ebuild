# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Getopt-Long-Descriptive/Getopt-Long-Descriptive-0.92.0.ebuild,v 1.2 2012/09/01 11:36:30 grobian Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=0.092
inherit perl-module

DESCRIPTION="Getopt::Long with usage text"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~ppc-aix ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND=">=dev-perl/Params-Validate-0.970.0
	dev-perl/IO-stringy
	dev-perl/Sub-Exporter
	virtual/perl-Scalar-List-Utils"
DEPEND="test? ( ${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
