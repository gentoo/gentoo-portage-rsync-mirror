# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/deprecated/deprecated-3.0.0.ebuild,v 1.12 2014/10/30 13:43:15 mrueg Exp $

EAPI="2"

USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="A Ruby library for handling deprecated code"
HOMEPAGE="http://rubyforge.org/projects/deprecated"

LICENSE="BSD"
SLOT="3"
KEYWORDS="amd64 ppc x86"
IUSE="test"

ruby_add_bdepend "test? ( dev-ruby/test-unit:2 )"

each_ruby_test() {
	${RUBY} -Ilib:. test/test_deprecated.rb || die "test failed"
}
