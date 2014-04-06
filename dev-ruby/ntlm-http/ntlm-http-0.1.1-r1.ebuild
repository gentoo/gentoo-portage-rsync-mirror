# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ntlm-http/ntlm-http-0.1.1-r1.ebuild,v 1.2 2014/04/05 23:22:05 mrueg Exp $

EAPI=5

# jruby → tests fail _badly_
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_TEST="none"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_DOC_SOURCES="lib README"
RUBY_FAKEGEM_EXTRADOC="README"

inherit ruby-fakegem eutils

DESCRIPTION="Ruby/NTLM HTTP provides NTLM authentication over http"
HOMEPAGE="http://www.mindflowsolutions.net/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

ruby_add_bdepend "test? ( >=dev-ruby/test-unit-2.5.1-r1 )"

all_ruby_prepare() {
	find . -name '*.rb' -exec sed -i -e 's:\r$::' {} +

	# We can't use RUBY_PATCHES for this because we need first to convert the files
	epatch "${FILESDIR}"/${P}+ruby-1.9.patch
}

each_ruby_test() {
	ruby-ng_testrb-2 test/*_test.rb
}
