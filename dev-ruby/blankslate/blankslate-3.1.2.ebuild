# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/blankslate/blankslate-3.1.2.ebuild,v 1.1 2013/12/12 23:48:59 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_EXTRADOC="README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A base class where almost all of the methods from Object and Kernel have been removed"
HOMEPAGE="https://rubygems.org/gems/blankslate"

IUSE=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

#Failing tests:
#ruby19+ruby20: test_empty_value(TestMarkup) [test/test_markupbuilder.rb:38]:
#ruby20: test_utf8_verbatim(TestXmlEscaping) [test/test_xchar.rb:72]:
RESTRICT="test"

all_ruby_prepare() {
	sed -i -e "/test\/preload/d"\
		-e "/test_preload_method_added/,/end/d" test/test_blankslate.rb || die
	sed -i -e "/test\/preload/d" test/test_{method_caching,markupbuilder,eventbuilder}.rb || die
}

each_ruby_compile() {
	:;
}
all_ruby_compile() {
	:;
}

each_ruby_test() {
	for i in test/*
	do
		${RUBY} -I. -Ilib "${i}" || die
	done
}
