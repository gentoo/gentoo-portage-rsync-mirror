# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-DKIM/Mail-DKIM-0.390.0.ebuild,v 1.9 2012/03/25 16:34:37 armin76 Exp $

EAPI=4

MODULE_AUTHOR=JASLONG
MODULE_VERSION=0.39
inherit perl-module

DESCRIPTION="Mail::DKIM - Signs/verifies Internet mail using DKIM message signatures"

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-perl/Crypt-OpenSSL-RSA-0.24
	virtual/perl-Digest-SHA
	virtual/perl-MIME-Base64
	dev-perl/Net-DNS
	dev-perl/MailTools"
RDEPEND="${DEPEND}"

SRC_TEST="do"

src_test(){
	# disable online tests
	for test in policy public_key verifier ; do
		mv "${S}"/t/${test}.t{,.disable}
	done
	perl-module_src_test
}
