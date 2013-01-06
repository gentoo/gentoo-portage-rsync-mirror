# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXML/XML-LibXML-1.900.0.ebuild,v 1.9 2012/06/09 06:25:41 tove Exp $

EAPI=4

MODULE_AUTHOR=SHLOMIF
MODULE_VERSION=1.90
inherit perl-module

DESCRIPTION="A Perl module to parse XSL Transformational sheets using gnome's libXSLT"
SRC_URI+=" http://dev.gentoo.org/~tove/distfiles/dev-perl/XML-LibXML/XML-LibXML-1.900.0-patch.tar.bz2"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="test"

DEPEND="
	>=dev-perl/XML-SAX-0.12
	>=dev-libs/libxml2-2.6.21
	>=dev-perl/XML-NamespaceSupport-1.07
"
RDEPEND="${DEPEND}
	!dev-perl/XML-LibXML-Common
"
DEPEND="${DEPEND}
	test? (
		dev-perl/Test-Pod
	)
"

SRC_TEST="do"

EPATCH_SUFFIX=patch
PATCHES=(
	"${WORKDIR}"/${MY_PN:-${PN}}-patch
)

# rac can't discern any difference between the build with or without
# this, and if somebody wants to reactivate it, get it out of global
# scope.
#export PERL5LIB=`perl -e 'print map { ":$ENV{D}/$_" } @INC'`
mytargets="pure_install doc_install"

src_compile() {
	export SKIP_SAX_INSTALL=1
	perl-module_src_compile
}

pkg_postinst() {
	pkg_update_parser add XML::LibXML::SAX::Parser
	pkg_update_parser add XML::LibXML::SAX
}

pkg_postrm() {
	pkg_update_parser remove XML::LibXML::SAX::Parser
	pkg_update_parser remove XML::LibXML::SAX
}

pkg_update_parser() {
	# pkg_update_parser [add|remove] $parser_module
	local action=$1
	local parser_module=$2

	if [[ "$ROOT" = "/" ]] ; then
		einfo "Update Parser: $1 $2"
		perl -MXML::SAX -e "XML::SAX->${action}_parser(q(${parser_module}))->save_parsers()" \
			|| ewarn "Update Parser: $1 $2 failed"
	else
		elog "To $1 $2 run:"
		elog "perl -MXML::SAX -e 'XML::SAX->${action}_parser(q(${parser_module}))->save_parsers()'"
	fi
}
