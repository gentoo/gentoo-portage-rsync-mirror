# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/flog/flog-4.2.0.ebuild,v 1.1 2013/11/07 06:30:48 graaff Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="Flog reports the most tortured code in an easy to read pain report."
HOMEPAGE="http://ruby.sadi.st/"
LICENSE="MIT"

KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/minitest )"

ruby_add_rdepend ">dev-ruby/ruby_parser-3.1.0:3
	>=dev-ruby/sexp_processor-4.4:4"

each_ruby_test() {
	${RUBY} -Ilib test/test_flog.rb || die
}
