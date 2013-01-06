# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-NamespaceSupport/XML-NamespaceSupport-1.110.0.ebuild,v 1.3 2012/05/09 15:08:24 aballier Exp $

EAPI=4

MODULE_AUTHOR=PERIGRIN
MODULE_VERSION=1.11
inherit perl-module

DESCRIPTION="A Perl module that offers a simple to process namespaced XML names"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

SRC_TEST="do"
