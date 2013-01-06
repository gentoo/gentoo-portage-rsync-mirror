# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MessageID/Email-MessageID-1.402.0.ebuild,v 1.3 2012/06/17 14:18:21 armin76 Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=1.402
inherit perl-module

DESCRIPTION="Generate world unique message-ids"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~sparc-solaris ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/Email-Address"
DEPEND="
	test? ( ${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
