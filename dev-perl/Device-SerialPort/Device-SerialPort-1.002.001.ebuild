# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Device-SerialPort/Device-SerialPort-1.002.001.ebuild,v 1.7 2009/07/02 19:32:29 jer Exp $

inherit perl-module versionator

MY_PV="$(delete_version_separator 2)"
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Serial port Perl Module"
HOMEPAGE="http://sendpage.org/device-serialport/"
SRC_URI="mirror://cpan/authors/id/C/CO/COOK/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc sparc x86"
IUSE=""

#From the module:
# If you run 'make test', you must make sure that nothing is plugged
# into '/dev/ttyS1'!
# Doesn't sound wise to enable SRC_TEST="do" - mcummings

DEPEND="dev-lang/perl"
