# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/crack/crack-0.4.1.ebuild,v 1.1 2013/11/20 23:24:18 mrueg Exp $

EAPI=5

USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.md History"

inherit ruby-fakegem

DESCRIPTION="Really simple JSON and XML parsing, ripped from Merb and Rails."
HOMEPAGE="https://github.com/jnunemaker/crack"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~amd64-linux ~x64-macos ~x64-solaris"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/shoulda dev-ruby/matchy )"
ruby_add_rdepend "dev-ruby/safe_yaml"

all_ruby_prepare() {
	# By default this gem wants to use the fork of matchy from the
	# same author of itself, but we don't package that (as it's
	# neither released on gemcutter nor tagged). On the other hand it
	# works fine with the mcmire gem that we package as
	# dev-ruby/matchy.
	sed -i -e 's:jnunemaker-matchy:mcmire-matchy:' test/test_helper.rb || die
}

each_ruby_prepare() {
	case ${RUBY} in
		*ruby19|*ruby20)
			# Remove test suite that is broken for ruby19.
			# Github Issues 26, 29, 32, 33.
			rm test/json_test.rb || die
			;;
		*)
			;;
	esac
}

each_ruby_test() {
	${RUBY} -Itest -Ilib test/*.rb || die
}
