# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-tools/MIME-tools-5.502.0.ebuild,v 1.8 2012/08/27 18:28:53 armin76 Exp $

EAPI=3

MODULE_AUTHOR=DSKOLL
MODULE_VERSION=5.502
inherit perl-module

DESCRIPTION="A Perl module for parsing and creating MIME entities"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 ~s390 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="test"

RDEPEND=">=virtual/perl-MIME-Base64-3.05
	virtual/perl-libnet
	dev-perl/URI
	virtual/perl-Digest-MD5
	dev-perl/libwww-perl
	dev-perl/HTML-Tagset
	dev-perl/HTML-Parser
	dev-perl/MailTools
	virtual/perl-File-Temp"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Deep
		dev-perl/Test-Pod
	)"

SRC_TEST="do"
