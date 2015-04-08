# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SOAP-Lite/SOAP-Lite-1.140.0.ebuild,v 1.2 2015/04/03 08:57:45 zlogene Exp $

EAPI=5

MODULE_AUTHOR=PHRED
MODULE_VERSION=1.14
inherit perl-module eutils

DESCRIPTION="Simple and lightweight interface to the SOAP protocol (sic) both on client and server side"

IUSE="jabber ssl test"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"

myconf="${myconf} --noprompt"

RDEPEND="
	dev-perl/Class-Inspector
	>=dev-perl/IO-SessionData-1.30.0
	dev-perl/libwww-perl
	virtual/perl-MIME-Base64
	virtual/perl-Scalar-List-Utils
	dev-perl/Task-Weaken
	dev-perl/URI
	dev-perl/XML-Parser
	dev-perl/MIME-tools
	ssl? (
		dev-perl/IO-Socket-SSL
		dev-perl/LWP-Protocol-https
		dev-perl/Crypt-SSLeay
	)
	jabber? ( dev-perl/Net-Jabber )
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		virtual/perl-IO
		virtual/perl-Test-Simple
		dev-perl/Test-Warn
		dev-perl/XML-Parser-Lite
	)
"

SRC_TEST="do"

src_test() {
	has_version '>=www-apache/mod_perl-2' && export MOD_PERL_API_VERSION=2
	perl-module_src_test
}
