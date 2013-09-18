# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Valid/Email-Valid-1.192.0.ebuild,v 1.1 2013/09/18 04:01:27 patrick Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=1.192
inherit perl-module

DESCRIPTION="Check validity of Internet email addresses."

SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~ppc64 ~x86 ~x86-linux"
IUSE="test"

RDEPEND="
	dev-perl/MailTools
"
DEPEND="
	test? ( ${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		dev-perl/Capture-Tiny
	)"

SRC_TEST="do"
