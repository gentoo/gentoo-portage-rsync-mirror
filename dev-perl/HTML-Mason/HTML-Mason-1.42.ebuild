# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Mason/HTML-Mason-1.42.ebuild,v 1.7 2011/06/19 15:50:32 armin76 Exp $

inherit depend.apache perl-module

DESCRIPTION="A HTML development and delivery Perl Module"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://www.masonhq.com/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ppc x86"
IUSE="modperl doc"
SRC_TEST="do"

RDEPEND="!modperl? ( virtual/perl-CGI )
	modperl? (
		www-apache/libapreq2
		>=www-apache/mod_perl-2
	)
	>=dev-perl/Params-Validate-0.7
	>=dev-perl/Class-Container-0.08
	>=dev-perl/Exception-Class-1.15
	dev-perl/HTML-Parser
	virtual/perl-Scalar-List-Utils
	virtual/perl-File-Spec
	>=dev-perl/Cache-Cache-1.01
	dev-lang/perl"

DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

want_apache2 modperl

mydoc="CREDITS UPGRADE"
myconf="--noprompts"

pkg_setup() {
	depend.apache_pkg_setup modperl
	perl-module_pkg_setup
}

perl-module_src_prep() {
	# Note about new modperl use flag
	if use !modperl ; then
		ewarn "HTML-Mason will only install with modperl support"
		ewarn "if the use flag modperl is enabled."
		sleep 5
	fi
	# rendhalver - needed to set an env var for the build script so it finds our apache.
	APACHE="${APACHE_BIN}" perl ${S}/Build.PL installdirs=vendor destdir=${D} ${myconf}
}

src_install () {
	perl-module_src_install
	# rendhalver - the html docs have subdirs so this gets all of them
	use doc && dohtml -r htdocs/*
}
