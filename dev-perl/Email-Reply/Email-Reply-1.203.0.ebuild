# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Reply/Email-Reply-1.203.0.ebuild,v 1.2 2013/12/06 13:49:04 zlogene Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=1.203
inherit perl-module

DESCRIPTION="Reply to a Message"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=dev-perl/Email-Abstract-2.13.1
	>=dev-perl/Email-MIME-1.900
	dev-perl/Email-Address"
DEPEND="${RDEPEND}"

SRC_TEST="do"
