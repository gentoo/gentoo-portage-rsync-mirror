# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Valid/Email-Valid-1.196.0.ebuild,v 1.2 2015/04/06 07:11:53 jer Exp $

EAPI=5

MODULE_AUTHOR=RJBS
MODULE_VERSION=1.196
inherit perl-module

DESCRIPTION="Check validity of Internet email addresses"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="test"

RDEPEND="
	virtual/perl-Carp
	virtual/perl-File-Spec
	dev-perl/IO-CaptureOutput
	virtual/perl-IO
	dev-perl/MailTools
	dev-perl/Net-DNS
	>=dev-perl/Net-Domain-TLD-1.650.0
	virtual/perl-Scalar-List-Utils
"
DEPEND="
	test? ( ${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		dev-perl/Capture-Tiny
		>=virtual/perl-Test-Simple-0.960.0
	)"

SRC_TEST="do"
