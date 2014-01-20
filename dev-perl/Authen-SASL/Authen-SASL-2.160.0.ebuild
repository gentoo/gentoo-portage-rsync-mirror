# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-SASL/Authen-SASL-2.160.0.ebuild,v 1.11 2014/01/20 20:28:06 vapier Exp $

EAPI=4

MODULE_AUTHOR=GBARR
MODULE_VERSION=2.16
inherit perl-module

DESCRIPTION="A Perl SASL interface"

SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="kerberos"

DEPEND="dev-perl/Digest-HMAC
	kerberos? ( dev-perl/GSSAPI )"
RDEPEND="${DEPEND}"

SRC_TEST="do"
export OPTIMIZE="$CFLAGS"
