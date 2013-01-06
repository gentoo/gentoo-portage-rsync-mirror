# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SVN-Mirror/SVN-Mirror-0.73.ebuild,v 1.7 2011/12/04 17:59:39 armin76 Exp $

inherit perl-module

DESCRIPTION="SVN::Mirror - Mirror remote repositories to local subversion repository"
SRC_URI="mirror://cpan/authors/id/C/CL/CLKAO/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/C/CL/CLKAO/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=dev-vcs/subversion-1.1.3
	>=dev-perl/URI-1.34
	>=dev-perl/TermReadKey-2.21
	>=dev-perl/SVN-Simple-0.26
	dev-perl/Data-UUID
	dev-perl/Class-Accessor
	dev-perl/TimeDate
	dev-perl/File-chdir
	dev-lang/perl"

pkg_setup() {
	if ! perl -MSVN::Core < /dev/null 2> /dev/null
	then
		eerror "You need subversion-1.0.4+ compiled with Perl bindings."
		eerror "USE=\"perl\" emerge subversion"
		die "Need Subversion compiled with Perl bindings."
	fi
}
