# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-IMAP-Simple-SSL/Net-IMAP-Simple-SSL-1.300.0.ebuild,v 1.1 2011/08/29 11:54:39 tove Exp $

EAPI=4

MODULE_AUTHOR=CWEST
MODULE_VERSION=1.3
inherit perl-module

DESCRIPTION="SSL support for Net::IMAP::Simple"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/IO-Socket-SSL
	dev-perl/Net-IMAP-Simple"
DEPEND="${RDEPEND}"

SRC_TEST="do"
