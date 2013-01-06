# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mk-livestatus/mk-livestatus-1.1.10_p1.ebuild,v 1.2 2012/09/03 18:48:33 idl0r Exp $

EAPI=3

GENTOO_DEPEND_ON_PERL=no
PERL_EXPORT_PHASE_FUNCTIONS=no

MY_PV="${PV/_p/p}"
MY_P="${PN}-${MY_PV}"

inherit perl-module python eutils

DESCRIPTION="Nagios/Icinga event broker module that allows quick/direct access to your status data"
HOMEPAGE="http://mathias-kettner.de/checkmk_livestatus.html"
SRC_URI="http://mathias-kettner.de/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples perl python test"

RDEPEND="perl? (
		dev-lang/perl
		virtual/perl-Digest-MD5
		virtual/perl-Thread-Queue
	)"
DEPEND="${RDEPEND}
	perl? (
		dev-perl/Module-Install
		test? (
			dev-perl/File-Copy-Recursive
			dev-perl/Test-Pod
			dev-perl/Test-Perl-Critic
			dev-perl/Test-Pod-Coverage
			dev-perl/Perl-Critic
			dev-perl/Perl-Critic-Policy-Dynamic-NoIndirect
			dev-perl/Perl-Critic-Deprecated
			dev-perl/Perl-Critic-Nits
		)
	)"

# For perl test
SRC_TEST="parallel"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# Use system Module::Install instead, it will be copied to $S by
	# Module::install itself.
	rm -rf api/perl/inc

	if use perl; then
		perl-module_src_prepare
	fi

	sed -i -e 's:$(LDFLAGS) -s:$(LDFLAGS):' src/Makefile.in || die

	epatch "${FILESDIR}/gcc-4.7-compile.patch"
}

src_configure() {
	econf

	if use perl; then
		cd api/perl/
		perl-module_src_configure
	fi
}

src_compile() {
	emake || die

	if use perl; then
		cd api/perl
		perl-module_src_compile
	fi
}

src_test() {
	if use perl; then
		cd api/perl

		export TEST_AUTHOR="Test Author"
		perl-module_src_test
	fi
}

src_install() {
	emake -C src/ DESTDIR="${D}" install-binPROGRAMS install-data-local || die

	if use perl; then
		cd api/perl
		perl-module_src_install
		cd "${S}"

		if use examples; then
			docinto examples/
			dodoc api/perl/examples/dump.pl || die
		fi
	fi
	if use python; then
		insinto $(python_get_sitedir)
		doins api/python/livestatus.py || die

		if use examples; then
			newdoc api/python/README README.python || die

			docinto examples/
			dodoc api/python/{example,example_multisite,make_nagvis_map}.py || die
		fi
	fi
}
