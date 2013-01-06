# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Audit/Mail-Audit-2.227.0.ebuild,v 1.5 2012/04/16 21:28:06 ranger Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=2.227
inherit perl-module

DESCRIPTION="Mail sorting/delivery module for Perl."

SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-perl/MIME-tools
	>=dev-perl/MailTools-1.15
	virtual/perl-libnet
	dev-perl/File-Tempdir
	>=dev-perl/File-HomeDir-0.61"
DEPEND="${RDEPEND}"

SRC_TEST=do
