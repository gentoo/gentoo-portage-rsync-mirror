# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MailTools/MailTools-2.120.0.ebuild,v 1.3 2013/03/25 20:37:32 ago Exp $

EAPI=4

MODULE_AUTHOR=MARKOV
MODULE_VERSION=2.12
inherit perl-module

DESCRIPTION="Manipulation of electronic mail addresses"

SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND="
	>=virtual/perl-libnet-1.70.300
	dev-perl/TimeDate
"
DEPEND="${RDEPEND}"

SRC_TEST="do"
