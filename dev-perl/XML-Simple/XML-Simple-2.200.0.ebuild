# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Simple/XML-Simple-2.200.0.ebuild,v 1.10 2013/08/30 13:36:10 zlogene Exp $

EAPI=4

MODULE_AUTHOR=GRANTM
MODULE_VERSION=2.20
inherit perl-module

DESCRIPTION="XML::Simple - Easy API to read/write XML (esp config files)"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="virtual/perl-Storable
	dev-perl/XML-SAX
	dev-perl/XML-LibXML
	>=dev-perl/XML-NamespaceSupport-1.04
	>=dev-perl/XML-Parser-2.30"
DEPEND="${RDEPEND}"

SRC_TEST="do"
