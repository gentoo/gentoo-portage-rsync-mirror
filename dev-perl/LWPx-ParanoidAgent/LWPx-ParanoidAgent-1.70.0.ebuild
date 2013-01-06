# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/LWPx-ParanoidAgent/LWPx-ParanoidAgent-1.70.0.ebuild,v 1.1 2011/08/30 11:30:41 tove Exp $

EAPI=4

MODULE_AUTHOR=BRADFITZ
MODULE_VERSION=1.07
inherit perl-module

DESCRIPTION="Subclass of LWP::UserAgent that protects you from harm"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/libwww-perl
	dev-perl/Net-DNS
	virtual/perl-Time-HiRes"
RDEPEND="${DEPEND}"

SRC_TEST=no
