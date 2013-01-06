# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Find/Email-Find-0.100.0.ebuild,v 1.4 2012/12/05 11:25:38 grobian Exp $

EAPI=4

MODULE_AUTHOR=MIYAGAWA
MODULE_VERSION=0.10
inherit perl-module

DESCRIPTION="Find RFC 822 email addresses in plain text"

SLOT="0"
KEYWORDS="amd64 hppa ~mips ppc ppc64 x86 ~x86-linux"
IUSE=""

RDEPEND="dev-perl/MailTools
	dev-perl/Email-Valid
	virtual/perl-Test-Simple"
DEPEND="${RDEPEND}"

SRC_TEST="do"
