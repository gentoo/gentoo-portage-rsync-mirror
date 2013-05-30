# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/temple/temple-0.6.5.ebuild,v 1.1 2013/05/30 06:00:36 graaff Exp $

EAPI=5
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGES EXPRESSIONS.md README.md"

RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="An abstraction and a framework for compiling templates to pure Ruby."
HOMEPAGE="http://github.com/judofyr/temple"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/bacon dev-ruby/tilt )"

each_ruby_test() {
	${RUBY} -S bacon -Ilib -Itest --automatic --quiet || die
}
