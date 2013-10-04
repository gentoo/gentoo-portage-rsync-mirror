# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/xml-simple/xml-simple-1.1.2-r1.ebuild,v 1.1 2013/10/04 18:28:28 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 jruby"

# Gem only contains lib code, and github repository has no tags.
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Easy API to maintain XML. It is a Ruby port of Grant McLean's Perl module XML::Simple."
HOMEPAGE="http://rubyforge.org/projects/xml-simple/ https://github.com/maik/xml-simple"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
