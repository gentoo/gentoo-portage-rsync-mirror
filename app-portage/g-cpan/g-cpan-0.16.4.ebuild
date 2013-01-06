# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/g-cpan/g-cpan-0.16.4.ebuild,v 1.1 2011/01/24 23:36:12 robbat2 Exp $

EAPI=2

inherit perl-module

DESCRIPTION="g-cpan: generate and install CPAN modules using portage"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/g-cpan.xml"
SRC_URI="mirror://gentoo/${P}.tar.gz
		 http://dev.gentoo.org/~robbat2/distfiles/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl
		>=dev-perl/yaml-0.60
		dev-perl/Shell-EnvImporter
		dev-perl/Log-Agent"

src_install() {
		perl-module_src_install
		diropts "-m0755"
		dodir "/var/tmp/g-cpan"
		keepdir "/var/tmp/g-cpan"
		dodir "/var/log/g-cpan"
		keepdir "/var/log/g-cpan"
}

pkg_postinst() {
	elog "You may wish to adjust the permissions on /var/tmp/g-cpan"
	elog "if you have users besides root expecting to use g-cpan."
	einfo "Please note that some CPAN packages need additional manual"
	einfo "parameters or tweaking, due to bugs in their build systems."
}
