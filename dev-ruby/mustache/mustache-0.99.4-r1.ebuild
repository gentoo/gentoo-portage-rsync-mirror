# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mustache/mustache-0.99.4-r1.ebuild,v 1.5 2012/10/28 19:27:23 armin76 Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="man:build"
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit multilib ruby-fakegem

DESCRIPTION="Mustache is a framework-agnostic way to render logic-free views."
HOMEPAGE="http://mustache.github.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

ruby_add_bdepend "doc? ( app-text/ronn )"

each_ruby_test() {
	${RUBY} -Ilib:. -e "Dir['test/*.rb'].each{|f| require f}"
}

all_ruby_install() {
	all_fakegem_install

	doman man/mustache.1 man/mustache.5
}
